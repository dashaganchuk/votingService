package com.dchuk.votingService.models;

import javax.persistence.*;
import java.util.List;

@Entity
public class Voting {

    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="VOTING_ID")
    private Long votingId;

    private String name;

    private String description;

    @Enumerated(EnumType.STRING)
    private VoitingStatus status = VoitingStatus.isNotStarted;

    @OneToMany(mappedBy="voting", cascade=CascadeType.ALL)
    private List<Option> options;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public VoitingStatus getStatus() {
        return status;
    }

    public void setStatus(VoitingStatus status) {
        this.status = status;
    }

    public Long getVotingId() {
        return votingId;
    }

    public void setVotingId(Long votingId) {
        this.votingId = votingId;
    }

    public List<Option> getOptions() {
        return options;
    }

    public void setOptions(List<Option> options) {
        this.options = options;
    }

    public enum VoitingStatus{
        isNotStarted,
        isVoting,
        isClosed
    }
}
