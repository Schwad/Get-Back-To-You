require 'csv'
require 'fileutils'

puts "Time manager activate"
puts ''
puts ''
file_path_data = "data.csv"
file_path_data_2 = "data1.csv"
file_path_completed = "complete.csv"
file_path_removed = "removed.csv"
destination_directory = "manager_data_backups"

while true
  puts ''
  such_length = File.open("data.csv").readlines.size
  command = gets.chomp
  fname = "data.csv"
  puts ''

  if command.split(//)[0..2].join('') == "add"    

     line_input = command.split(//)[4..-1].join('') + ",\n"
     time = Time.new

     if line_input.split(//)[0..3].join('') == "call"
      line_command = line_input.split(//)[5..-5].join('')
       CSV.open("data.csv", "ab") do |csv|
        csv << [such_length,"call", line_command, "#{time.hour}:#{time.min} #{time.day}/#{time.month}", line_input.split(//)[-3] ]
      end

      elsif line_input.split(//)[0..4].join('') == "email"
         line_command = line_input.split(//)[6..-5].join('')
         CSV.open("data.csv", "ab") do |csv|
          csv << [such_length,"email", line_command, "#{time.hour}:#{time.min} #{time.day}/#{time.month}", line_input.split(//)[-3] ]
        end
     end

  elsif command.split(//)[0..5].join('') == "ls all"
    i = 0
    CSV.open("data.csv", :row_sep => :auto, :col_sep => ",") do |csv|
      csv.each {|a,b,c,d,e| puts "#{i}.  #{b} #{c}, added #{d}, priority level #{e}.\n\n" unless a == "RowNum"  ##REMOVED 'ID number #{a}''
        i += 1
      }
    end

  elsif command.split(//)[0..7].join('') == "ls call"
    
    CSV.foreach("data.csv") do |row|
      if row[1] == "call"
        puts "#{row[1]} #{row[2]}, added #{row[3]}, priority level #{row[4]}. \n\n" ##REMOVED 'ID number #{row[0]}'
      end
    end

  elsif command.split(//)[0..7].join('') == "ls email"
    
    CSV.foreach("data.csv") do |row|
      if row[1] == "email"
        puts "#{row[1]} #{row[2]}, added #{row[3]}, priority level #{row[4]}. \n\n" ##REMOVED 'ID number #{row[0]}'
      end
    end

  elsif command.split(//)[0..3].join('') == "exit"
    exit

  elsif command.split(//)[0..5].join('') == "remove"
    such_id = command.split(//)[7..-1].join('').to_i + 1
    current_file = CSV.read("data.csv")
    time = Time.new
    timefile ="#{time.hour}:#{time.min}, #{time.day}/#{time.month}"

    #copy the file
    CSV.foreach("data.csv") do |csvbig|
      if $INPUT_LINE_NUMBER == such_id
          csvbig << timefile
          CSV.open("removed.csv", "ab") do |csv|
            csv << csvbig
          end
        puts "Task #{$INPUT_LINE_NUMBER - 1} removed!"
      end
    end

    #delete the file
    f = File::open("data.csv", "r")
    dest=File::open("data1.csv", "w")
    f.each_line do |line|
      next if f.lineno == such_id
      dest.write(line)
    end
    f.close
    dest.close
    FileUtils.cp(file_path_data_2, "data.csv")

  elsif command.split(//)[0..7].join('') == "complete"
    such_id = command.split(//)[9..-1].join('').to_i + 1
    guests = CSV.read('data.csv',headers:true)
    current_file = CSV.read("data.csv")
    time = Time.new
    timefile ="#{time.hour}:#{time.min}, #{time.day}/#{time.month}"

    #complete the file
    CSV.foreach("data.csv") do |csvbig|
      if $INPUT_LINE_NUMBER == such_id
          csvbig << timefile
          CSV.open("complete.csv", "ab") do |csv|
            csv << csvbig
          end
        puts "Task #{$INPUT_LINE_NUMBER - 1} completed!"
      end
    end

    #delete the file
    f = File::open("data.csv", "r")
    dest=File::open("data1.csv", "w")
    f.each_line do |line|
      next if f.lineno == such_id
      dest.write(line)
    end
    f.close
    dest.close
    FileUtils.cp(file_path_data_2, "data.csv")

  elsif command.split(//)[0..5].join('') == "backup"
    if command.split(//)[7..10].join('') == "data"
      FileUtils.cp(file_path_data, destination_directory)
      puts "Backed up data file."
    elsif command.split(//)[7..10].join('') == "comp"
      FileUtils.cp(file_path_completed, destination_directory)
       puts "Backed up completed file."
    elsif command.split(//)[7..10].join('') == "remo"
      FileUtils.cp(file_path_removed, destination_directory)
      puts "Backed up removed file."
    else 
      puts "backup failed, unclear instructions. Type 'help' for more info."
    end

  else
    puts "The standard way to do a command sets type, content and priority.\n\n Such as 'call jeff smith before thursday 2'.\n\n 1 is the highest priority and down from there. Other commands include 'ls all', 'ls call', 'ls email', and exit. Those commands list your todos.\n\n You may backup your data file, completed file, \n\n or deleted files with 'backup data' or \n\n 'backup completed' or 'backup removed'. \n\n If you have an issue with this program you can report it at https://github.com/Schwad"
  end
end
