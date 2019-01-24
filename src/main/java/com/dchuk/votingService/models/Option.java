package com.dchuk.votingService.models;


import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

@Entity
public class Option {
    @Id
    @GeneratedValue(strategy= GenerationType.AUTO)
    @Column(name="OPTION_ID")
    private Long optionID;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="VOTING_ID")
    @JsonIgnore
    private Voting voting;

    private String name;

    @Column(columnDefinition = "integer default 0")
    private Integer count = 0;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Long getOptionID() {
        return optionID;
    }

    public void setOptionID(Long optionID) {
        this.optionID = optionID;
    }

    public Voting getVoting() {
        return voting;
    }

    public void setVoting(Voting voting) {
        this.voting = voting;
    }
}
