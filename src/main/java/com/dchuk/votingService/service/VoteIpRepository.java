package com.dchuk.votingService.service;

import com.dchuk.votingService.models.VoteIp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface VoteIpRepository extends JpaRepository<VoteIp, Long> {


    @Query(value = "SELECT count(*) FROM VOTE_IP v where v.ip = ?1 and v.voting_id = ?2",
            nativeQuery=true)
    Integer findByIpAndVotingId(String ip, Long votingId);
}
