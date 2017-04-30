# Add seed data here. Seed your database with `rake db:seed`
parser = LibraryParser.new('db/data')
parser.call
