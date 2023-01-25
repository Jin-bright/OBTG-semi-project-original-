package com.sh.obtg.share.model.exception;

public class ShareException extends RuntimeException {

	public ShareException() {
		super();
	}

	public ShareException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

	public ShareException(String message, Throwable cause) {
		super(message, cause);
	}

	public ShareException(String message) {
		super(message);
	}

	public ShareException(Throwable cause) {
		super(cause);
	}
	
}
