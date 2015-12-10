# To get work done by author for local repo
def get_sha str
	line_parse = str.split(" ")
	if line_parse[0] == "commit"
		line_parse[1]
	end
end

def export filename="commits.txt", data
	new_line = "\n"
	80.times do
		new_line << "="
	end
	begin
		fp = open(filename, 'a')
		fp.write(data)
		fp.write(new_line)
	rescue Exception => e
		puts e.message
	end
end

author = ARGV[0].to_s
if author.nil?
	puts "Argument missing"
else
	cmd = "git log --author=#{author}"
	commits = IO.popen("#{cmd}").readlines
	if commits.empty?
		puts "#{author} doesnot have any commits"
	else
		commits.each do |line|
			sha = get_sha(line)
			if !sha.nil?
				cmd = "git show #{sha}"
				log = IO.popen(cmd).readlines.join("")
				export log
			end
		end
	end
end
