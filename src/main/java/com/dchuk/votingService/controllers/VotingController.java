package com.dchuk.votingService.controllers;


import com.dchuk.votingService.exceptions.VotingNotFoundException;
import com.dchuk.votingService.models.VoteIp;
import com.dchuk.votingService.models.Voting;
import com.dchuk.votingService.service.VoteIpService;
import com.dchuk.votingService.service.VotingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
public class VotingController {

    @Autowired
    VotingService votingService;
    @Autowired
    VoteIpService voteIpService;

    @GetMapping({"/"})
    public String index(Model model) {
        List<Voting> votings = votingService.findAll();
        model.addAttribute("votings", votings);
        return "votingsView";
    }

    @RequestMapping(value="/addNewVoiting",method= RequestMethod.POST)
    public @ResponseBody
    Voting save( @RequestBody Voting voting)
    {
        return votingService.createVoting(voting);
    }

    @RequestMapping(value="/poll/{votingID}",method= RequestMethod.GET)
    public String start( Model model,@PathVariable("votingID") Long votingId, HttpServletRequest request)
    {
        if(votingService.findVoting(votingId).orElse(null) == null){
           throw new VotingNotFoundException();
        }
        Voting voting = votingService.findVoting(votingId).get();

        if (voting.getStatus() == Voting.VoitingStatus.isClosed){
            model.addAttribute("voting", voting);
            return "votingStatistic";

        }
        VoteIp voteIp = new VoteIp(request.getRemoteAddr(),voting.getVotingId());
        if(voteIpService.checkVoteIp(voteIp)){
            model.addAttribute("voting", voting);
            return "votingStatistic";
        }

        if (voting.getStatus() != Voting.VoitingStatus.isVoting) {
            voting.setStatus(Voting.VoitingStatus.isVoting);
            votingService.updateVoting(voting);
        }
        model.addAttribute("voting", voting);
        return "votingProcess";
    }

    @RequestMapping(value="/poll/{votingID}/{optionNo}",method= RequestMethod.POST)
    public @ResponseBody
    boolean registerVote( @PathVariable("votingID") Long votingId, @PathVariable("optionNo") Integer optionNo, HttpServletRequest request)
    {
        if(votingService.findVoting(votingId).orElse(null) == null){
            throw new VotingNotFoundException();
        }
        Voting voting = votingService.findVoting(votingId).get();
        VoteIp voteIp = new VoteIp(request.getRemoteAddr(),voting.getVotingId());
        voting.getOptions().get(optionNo).setCount(voting.getOptions().get(optionNo).getCount()+1);
        votingService.updateOption(voting.getOptions().get(optionNo).getOptionID(),voting.getOptions().get(optionNo));
        voteIpService.createVoting(voteIp);
        return true;
    }

    @RequestMapping(value="/poll/{votingID}/statistic",method= RequestMethod.GET)
    public String statistic( Model model,@PathVariable("votingID") Long votingId)
    {
        if(votingService.findVoting(votingId).orElse(null) == null){
            throw new VotingNotFoundException();
        }
        Voting voting = votingService.findVoting(votingId).get();
        model.addAttribute("voting", voting);
        return "votingStatistic";
    }

    @RequestMapping(value="/stop/{votingId}",method= RequestMethod.POST)
    public @ResponseBody
    Boolean stopVoting(@PathVariable("votingId") Long votingId)
    {
        if(votingService.findVoting(votingId).orElse(null) == null){
            throw new VotingNotFoundException();
        }
        Voting voting = votingService.findVoting(votingId).get();
        voting.setStatus(Voting.VoitingStatus.isClosed);
        votingService.updateVoting(voting);
        return true;
    }
}
