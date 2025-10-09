class Logger
    def initialize
        @timestamp = []
        @severity = []
        @message = []
    end

    def log(severity, message)
        time = Time.now
        @timestamp << time
        @severity << severity
        @message << message
    end

    def print_warn
        for i in 0...@message.length
            if @severity[i] == :warn
                puts "#{@timestamp[i].strftime("%Y-%m-%d %H:%M:%S")} #{@message[i]}"
            end
        end
    end

    def print_all
        for i in 0...@message.length
            puts "#{@timestamp[i].strftime("%Y-%m-%d %H:%M:%S")} #{@severity[i]} #{@message[i]}"
        end
    end
end

logger = Logger.new
logger.log(:warn, "Something bad has happened")
sleep 1
logger.log(:warn, "Something even worse has happened")
logger.log(:debug, "Just wanted to say hello")
logger.log(:error, "You can't do that")

logger.print_warn
logger.print_all