class Pochette::BtcTrezorTransactionBuilder < Pochette::BaseTrezorTransactionBuilder
  def self.backend
    @backend || Pochette::BtcTransactionBuilder.backend || Pochette.btc_backend
  end

  def self.force_bip143
    false
  end

  def initialize(options)
    super(options)
    build_trezor_inputs
  end

  def build_trezor_inputs
    base_build_trezor_inputs(inputs || []) do |input, hash, address|
      if address.first.first.in?(%w[2 3])
        hash[:amount] = input[3].to_s
        hash[:script_type] = 'SPENDP2SHWITNESS'
      end
    end
  end
end
