package com.wimilee.stock.commons.exception;

public abstract class AbstractException extends Exception {
    private static final long serialVersionUUID = -1L;

    public AbstractException(String message) {
        super(message);
    }

}
