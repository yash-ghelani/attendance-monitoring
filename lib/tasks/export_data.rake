namespace :export do
    desc "Export users" 
    task :export_to_seeds => :environment do
      TimetabledSession.all.each do |session| 
        serialized = session.as_json
        puts "TimetabledSession.find_or_create_by(#{serialized})"
      end 

      SessionRegisteredLecturer.all.each do |lecturer|
        serialized = lecturer.as_json
        puts "SessionRegisteredLecturer.find_or_create_by(#{serialized})"
      end
    end
  end