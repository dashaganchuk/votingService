package com.dchuk.votingService.models;

import javax.persistence.*;

@Entity
public class VoteIp {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="VOTE_IP_ID")
    private Long voteIpId;
    private String ip;

    @Column(name="VotingId")
    private Long votingId;

    public VoteIp(String ip, Long votingId) {
        this.ip = ip;
        this.votingId = votingId;
    }

    public Long getVoteIpId() {
        return voteIpId;
    }

    public void setVoteIpId(Long voteIpId) {
        this.voteIpId = voteIpId;
    }

    public Long getVotingId() {
        return votingId;
    }

    public void setVotingId(Long votingId) {
        this.votingId = votingId;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }


}
