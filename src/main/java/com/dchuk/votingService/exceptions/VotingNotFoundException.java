package com.dchuk.votingService.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value= HttpStatus.NOT_FOUND, reason="No such Voting")
public class VotingNotFoundException extends RuntimeException{
}
