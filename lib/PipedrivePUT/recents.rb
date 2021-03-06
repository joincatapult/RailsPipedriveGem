module PipedrivePUT
  class Recents

include PipedrivePUT

require 'rest-client'

			def self.key
				return @@key
			end


		#gets Recent changes from types in Pipedrive
			def self.getRecent(time)

				if time.nil?
					raise "No time entered. Correct format is YYYY-MM-DD HH:MM:SS"
				else
					@time = time.utc
					@formattedTime = @time.strftime("%F %T")
					#puts @formattedTime
						@start = 0
					  
					  	table = Array.new
					  	@more_items = true
					  	tablesize = 0

						while @more_items == true do
							count = 0
							#puts @more_items
							@base = 'https://api.pipedrive.com/v1/recents?since_timestamp=' + @formattedTime.to_s + '&' + 'start=' + @start.to_s + '&limit=500&api_token=' + @@key.to_s
							#puts @base
							@content = open(@base.to_s).read
							@parsed = JSON.parse(@content)

							while count < @parsed["data"].size
								table.push(@parsed["data"][count])
								table[tablesize] = @parsed["data"][count]
								count = count +1
								tablesize = tablesize + 1
							end

							@pagination = @parsed['additional_data']['pagination']
							@more_items = @pagination['more_items_in_collection']
							#puts @more_items
							@start = @pagination['next_start']
							#puts @start
						 end

					return table
					end
				end

			end
	end