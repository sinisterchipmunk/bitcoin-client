module Bitcoin::Errors
  class RPCError < StandardError
    attr_reader :code
    attr_reader :message

    def initialize(code, message)
      @code = code
      @message = message
    end

    def to_s
      { code: code, message: message }.to_s
    end
  end

  def self.define_errors(super_klass, errors)
    @errors ||= {}
    errors.each do |error_code, name|
      klass = Class.new(super_klass) { def code; error_code; end }
      self.const_set(name, klass)
      @errors[error_code] = klass
    end
  end

  def self.dispatch_error(code, message)
    @errors ||= {}
    error = @errors[code]
    return GeneralError if not error
    return error.new(code, message)
  end

  class GeneralError < RPCError; end
  class ClientError < RPCError; end
  class WalletError < RPCError; def code; -4; end; end
  class UnknownError < RPCError; end

  define_errors(GeneralError, {
    -32600 => 'InvalidRequest',
    -32601 => 'MethodNotFound',
    -32602 => 'InvalidParams',
    -32603 => 'InternalError',
    -32700 => 'ParseError',
    -1 => 'MiscError',
    -2 => 'ForbiddenBySafeMode',
    -3 => 'TypeError',
    -5 => 'InvalidAddressOrKey',
    -7 => 'OutOfMemory',
    -8 => 'InvalidParameter',
    -20 => 'DatabaseError',
    -22 => 'DeserializationError',
    -18 => 'ServerNotStarted',
  })

  define_errors(ClientError, {
    -9 => 'ClientNotConnected',
    -10 => 'ClientInInitialDownload',
    -23 => 'ClientNodeAlreadyAdded',
    -24 => 'ClientNodeNotAdded',
  })

  define_errors(WalletError, {
    -6 => 'WalletInsufficientFunds',
    -11 => 'WalletInvalidAccountName',
    -12 => 'WalletKeypoolRanOut',
    -13 => 'WalletUnlockNeeded',
    -14 => 'WalletPassphraseIncorrect',
    -15 => 'WalletWrongEncState',
    -16 => 'WalletEncryptionFailed',
    -17 => 'WalletAlreadyUnlocked',
  })
end
