module CarbonMU
  class OverlordSupervisionGroup < Celluloid::SupervisionGroup
    supervise Overlord, as: :overlord, args: ["0.0.0.0", 8421]

    def self.shutdown
      Actor[:overlord].finalize
    end
  end
end
