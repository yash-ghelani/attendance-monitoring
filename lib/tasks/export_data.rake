namespace :export do
    desc "Export users" 
    task :export_to_seeds => :environment do
      TimetabledSession.all.each do |session| 
        serialized = session.as_json
        puts "TimetabledSession.first_or_create(#{serialized})"
      end 
    end
  end