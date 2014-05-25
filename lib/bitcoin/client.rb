class Bitcoin::Client
  attr_reader :api
  def user; api.user; end
  def pass; api.pass; end
  def host; api.host; end
  def port; api.port; end
  def ssl;  api.ssl;  end
  def ssl?; api.ssl?; end
  def user=(a); api.user = a; end
  def pass=(a); api.pass = a; end
  def host=(a); api.host = a; end
  def port=(a); api.port = a; end
  def ssl=(a);  api.ssl  = a; end

  def options
    api.options
  end

  def initialize(user, pass, options = {})
    @api = Bitcoin::API.new({ :user => user, :pass => pass }.merge(options))
  end

  # Safely copies wallet.dat to destination, which can be a directory or a path with filename.
  def backupwallet(destination)
    @api.request 'backupwallet', destination
  end

  # Creates a multi-signature address and returns a json object
  def createmultisig(nrequired, keys)
      @api.request 'createmultisig', nrequired, keys
  end

  # nCreate a transaction spending given inputs
  # (array of objects containing transaction id and output number), sending to given address(es)
  def createrawtransaction(transactionid = nil, address_amount)
      @api.request 'createrawtransaction', transactionid, address_amount
  end

  # Return a JSON object representing the serialized, hex-encoded transaction.
  def decoderawtransaction(hexstring)
      @api.request 'decoderawtransaction', hexstring
  end

  # Returns the account associated with the given address.
  def getaccount(bitcoinaddress)
    @api.request 'getaccount', bitcoinaddress
  end

  # Returns the current bitcoin address for receiving payments to this account.
  def getaccountaddress(account)
    @api.request 'getaccountaddress', account
  end

  #	Returns the list of addresses for the given account.
  def getaddressesbyaccount(account)
    @api.request 'getaddressesbyaccount', account
  end

  # If +account+ is not specified, returns the server's total available balance.
  # If +account+ is specified, returns the balance in the account.
  def getbalance(account = nil, minconf = 1)
    @api.request 'getbalance', account, minconf
  end

  # Dumps the block existing at specified height.
  # Note: this is not available in the official release
  def getblockbycount(height)
    @api.request 'getblockbycount', height
  end

  # Dumps the block existing with specified hash.
  def getblock(hash)
    block = @api.request 'getblock', hash
    block["time"] = Time.at(block["time"]).utc
    block
  end

  # Returns the number of blocks in the longest block chain.
  def getblockcount
    @api.request 'getblockcount'
  end

  # Returns the block number of the latest block in the longest block chain.
  def getblocknumber
    @api.request 'getblocknumber'
  end

  # Returns hash of block in best-block-chain at <index>; index 0 is the genesis block
  def getblockhash(index)
    @api.request 'getblockhash', index
  end

  # Returns the number of connections to other nodes.
  def getconnectioncount
    @api.request 'getconnectioncount'
  end

  # Returns the proof-of-work difficulty as a multiple of the minimum difficulty.
  def getdifficulty
    @api.request 'getdifficulty'
  end

  # Returns true or false whether bitcoind is currently generating hashes
  def getgenerate
    @api.request 'getgenerate'
  end

  # Returns a recent hashes per second performance measurement while generating.
  def gethashespersec
    @api.request 'gethashespersec'
  end

  # Returns an object containing various state info.
  def getinfo
    @api.request 'getinfo'
  end

  # Returns an object containing mining info.
  def getmininginfo
    @api.request 'getmininginfo'
  end

  # Returns a new bitcoin address for receiving payments. If +account+ is specified (recommended),
  # it is added to the address book so payments received with the address will be credited to +account+.
  def getnewaddress(account = nil)
    @api.request 'getnewaddress', account
  end

  # Returns the total amount received by addresses with +account+ in transactions
  # with at least +minconf+ confirmations.
  def getreceivedbyaccount(account, minconf = 1)
    @api.request 'getreceivedbyaccount', account, minconf
  end

  # Returns the total amount received by +bitcoinaddress+ in transactions with at least +minconf+ confirmations.
  def getreceivedbyaddress(bitcoinaddress, minconf = 1)
    @api.request 'getreceivedbyaddress', bitcoinaddress, minconf
  end

  # Get detailed information about +txid+
  def gettransaction(txid)
    @api.request 'gettransaction', txid
  end

  # If +data+ is not specified, returns formatted hash data to work on:
  #
  #  :midstate => precomputed hash state after hashing the first half of the data
  #  :data     => block data
  #  :hash1    => formatted hash buffer for second hash
  #  :target   => little endian hash target
  #
  # If +data+ is specified, tries to solve the block and returns true if it was successful.
  def getwork(data = nil)
    @api.request 'getwork', data
  end

  # List commands, or get help for a command.
  def help(command = nil)
    @api.request 'help', command
  end
  
  # Adds a private key (as returned by dumpprivkey) to your wallet.
  def importprivkey(bitcoinprivkey, label = nil, rescan = true)
    @api.request 'importprivkey', bitcoinprivkey, label, rescan
  end

  # Returns Object that has account names as keys, account balances as values.
  def listaccounts(minconf = 1)
    @api.request 'listaccounts', minconf
  end

  # Returns an array of objects containing:
  #
  #   :account       => the account of the receiving addresses
  #   :amount        => total amount received by addresses with this account
  #   :confirmations => number of confirmations of the most recent transaction included
  #
  def listreceivedbyaccount(minconf = 1, includeempty = false)
    @api.request 'listreceivedbyaccount', minconf, includeempty
  end

  # Returns an array of objects containing:
  #
  #   :address       => receiving address
  #   :account       => the account of the receiving address
  #   :amount        => total amount received by the address
  #   :confirmations => number of confirmations of the most recent transaction included
  #
  # To get a list of accounts on the system, execute bitcoind listreceivedbyaddress 0 true
  def listreceivedbyaddress(minconf = 1, includeempty = false)
    @api.request 'listreceivedbyaddress', minconf, includeempty
  end

  # Returns up to +count+ most recent transactions for account +account+.
  def listtransactions(account = '' , count = 10, from = 0)
    @api.request 'listtransactions', account, count, from
  end

  # Move from one account in your wallet to another.
  def move(fromaccount, toaccount, amount, minconf = 1, comment = nil)
    @api.request 'move', fromaccount, toaccount, amount, minconf, comment
  end

  # +amount+ is a real and is rounded to 8 decimal places. Returns the transaction ID if successful.
  def sendfrom(fromaccount, tobitcoinaddress, amount, minconf = 1, comment = nil, comment_to = nil)
    @api.request 'sendfrom', fromaccount, tobitcoinaddress, amount, minconf, comment, comment_to
  end

  # Submits raw transaction (serialized, hex-encoded) to local node and network.
  def sendrawtransaction(hexstring)
    @api.request 'sendrawtransaction', hexstring
  end
  # +amount+ is a real and is rounded to 8 decimal places
  def sendtoaddress(bitcoinaddress, amount, comment = nil, comment_to = nil)
    @api.request 'sendtoaddress', bitcoinaddress, amount, comment, comment_to
  end

  def sendmany(fromaccount, addresses_amounts, minconf = 1, comment = nil)
    @api.request 'sendmany', fromaccount, addresses_amounts, minconf, comment
  end

  # Sets the account associated with the given address.
  def setaccount(bitcoinaddress, account)
    @api.request 'setaccount', bitcoinaddress, account
  end

  # +generate+ is true or false to turn generation on or off.
  # Generation is limited to +genproclimit+ processors, -1 is unlimited.
  def setgenerate(generate, genproclimit = -1)
    @api.request 'setgenerate', generate, genproclimit
  end

  # Sign inputs for raw transaction (serialized, hex-encoded).
  def signrawtransaction(hexstring, transaction = nil, privatekey =nil, sighashtype = "ALL")
    @api.request 'signrawtransaction', hexstring, transaction, privatekey, sighashtype  
  end
  
  # Stop bitcoin server.
  def stop
    @api.request 'stop'
  end

  # Return information about +bitcoinaddress+.
  def validateaddress(bitcoinaddress)
    @api.request 'validateaddress', bitcoinaddress
  end

  # Sign a message using +bitcoinaddress+.
  def signmessage(bitcoinaddress, message)
    @api.request 'signmessage', bitcoinaddress, message
  end

  # Verify signature made by +bitcoinaddress+.
  def verifymessage(bitcoinaddress, signature, message)
    @api.request 'verifymessage', bitcoinaddress, signature, message
  end

  # Stores the wallet decryption key in memory for +timeout+ seconds.
  def walletpassphrase(passphrase, timeout)
    @api.request 'walletpassphrase', passphrase, timeout
  end

  # Removes the wallet encryption key from memory, locking the wallet.
  # After calling this method, you will need to call walletpassphrase again
  # before being able to call any methods which require the wallet to be
  # unlocked.
  def walletlock
    @api.request 'walletlock'
  end

  alias account getaccount
  alias account_address getaccountaddress
  alias addresses_by_account getaddressesbyaccount
  alias balance getbalance
  alias block_by_count getblockbycount
  alias block_count getblockcount
  alias block_number getblocknumber
  alias block_hash getblockhash
  alias connection_count getconnectioncount
  alias difficulty getdifficulty
  alias generate? getgenerate
  alias hashes_per_sec gethashespersec
  alias info getinfo
  alias new_address getnewaddress
  alias received_by_account getreceivedbyaccount
  alias received_by_address getreceivedbyaddress
  alias transaction gettransaction
  alias work getwork
  alias get_work getwork
  alias accounts listaccounts
  alias list_received_by_account listreceivedbyaccount
  alias list_received_by_address listreceivedbyaddress
  alias transactions listtransactions
  alias list_transactions listtransactions
  alias send_from sendfrom
  alias send_to_address sendtoaddress
  alias send_many sendmany
  alias account= setaccount
  alias set_account setaccount
  alias generate= setgenerate
  alias set_generate setgenerate
  alias validate_address validateaddress
  alias sign_message signmessage
  alias verify_message verifymessage
end
