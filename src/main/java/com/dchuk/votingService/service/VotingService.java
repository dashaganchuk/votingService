package com.dchuk.votingService.service;

import com.dchuk.votingService.models.Option;
import com.dchuk.votingService.models.Voting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class VotingService {
    @Autowired
    VotingRepository votingRepository;

    // --------------------------------------------
        // CRUD OPERATIONS FOR PARENT RECORDS (Voting)

    public Voting createVoting(Voting voting) {
        for (Option option:voting.getOptions()){
            option.setVoting(voting);
        }
        return votingRepository.save(voting);

    }

    public List findAll() {
        return votingRepository.findAll();
    }

    public Optional<Voting> findVoting(long votingId) {
        return votingRepository.findById(votingId);
    }

    public Voting updateVoting(Voting voting) {
        Voting updatedVoting = findVoting(voting.getVotingId()).get();
        return votingRepository.save(updatedVoting);
    }

    @Autowired
    private OptionRepository optionRepository;

        // --------------------------------------------
        // CRUD OPERATIONS FOR CHILD RECORDS (OptionS)

    public Option updateOption(long optionId, Option Option) {
        Option savedOption = optionRepository.getOne(optionId);
        savedOption.setName(Option.getName());
        savedOption.setCount(Option.getCount());
        optionRepository.save(savedOption);
        return savedOption;
    }


}
