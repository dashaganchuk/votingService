package com.dchuk.votingService.service;

import com.dchuk.votingService.models.VoteIp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class VoteIpService {


    // --------------------------------------------
    // CRUD OPERATIONS FOR RECORDS (VoteId)

    @Autowired
    VoteIpRepository voteIpRepository;

    public VoteIp createVoting(VoteIp voteIp) {
        return voteIpRepository.save(voteIp);
    }

    public Boolean checkVoteIp(VoteIp voteIp){
        return voteIpRepository.findByIpAndVotingId(voteIp.getIp(),voteIp.getVotingId())>0;
    }
}
