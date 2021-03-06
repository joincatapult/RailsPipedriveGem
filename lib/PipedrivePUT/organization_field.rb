module PipedrivePUT
  class OrganizationFields

include PipedrivePUT

		def self.getAllOrganizationFields
			  
			  @start = 0
			  
			  table = Array.new
			  @more_items = true
			  tablesize = 0
			  while @more_items == true do
				count = 0
				#puts @more_items
				@base = 'https://api.pipedrive.com/v1/organizationFields?start=' + @start.to_s + '&limit=500&api_token=' + @@key.to_s
				#puts @base
				@content = open(@base.to_s).read
				@parsed = JSON.parse(@content)

				while count < @parsed["data"].size
					#table.push(@parsed["data"][count])
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

		#Add an organization Field
		def self.addOrganizationField(fieldName, fieldType, options = {})
			#args.each_with_index{ |arg, i| puts "#{i+1}. #{arg}" } 

			@url = 'https://api.pipedrive.com/v1/organizationFields?api_token=' + @@key.to_s

			if (!options.nil?)

				options.merge!(:name => fieldName.to_s)
				options.merge!(:field_type => fieldType.to_s)

				#puts options

				response = HTTParty.post(@url.to_s, :body => options.to_json, :headers => {'Content-type' => 'application/json'})
			end
		end

	end
end