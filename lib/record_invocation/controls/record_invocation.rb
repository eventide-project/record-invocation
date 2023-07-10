module RecordInvocation
  module Controls
    ## Review control name - Antoine Sun Jul 9 2023
    module RecordInvocation
      def self.example
        Example.new
      end

      class Example
        include ::RecordInvocation
      end
    end
  end
end
