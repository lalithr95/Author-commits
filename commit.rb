# To get work done by author for local repo
def get_sha str
	line_parse = str.split(" ")
	if line_parse[0] == "commit"
		line_parse[1]
	end
end

author = ARGV[0]
if author.nil?
	puts "Argument missing"
else
	commits = %x{'git show #{author}'}
	if commits.empty?
		puts "#{author} doesnot have any commits"
	else
		commits.split('\n').each do |line|
			sha = get_sha(line)
			log = %x{'git log #{sha}'}
			puts log
		end
	end
end
