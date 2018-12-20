require_relative '../../lib/Register.rb'

describe "Checking class initialization" do
  before{
    @data = Database.new
  }

  it "Returns not nil while created" do
    expect(@data).not_to be nil
  end

  it "Returns instance of Database while created" do
    expect(@data).to be_instance_of(Database)
  end

  after{
    @data = nil
  }

end

describe "Checking Database class functionality" do
  let(:tables)do[
      [:Grade,[:id, :grade, :comment, :date, :StudentSubject_id],[[:id, {:allow_null=>false, :default=>nil, :db_type=>"integer", :primary_key=>true, :auto_increment=>true, :type=>:integer, :ruby_default=>nil}], [:grade, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}], [:comment, {:allow_null=>false, :default=>nil, :db_type=>"varchar(500)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>500}], [:date, {:allow_null=>false, :default=>nil, :db_type=>"varchar(30)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>30}], [:StudentSubject_id, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}]]],
      [:Note,[:id, :description, :date, :Student_id, :Teacher_id],[[:id, {:allow_null=>false, :default=>nil, :db_type=>"integer", :primary_key=>true, :auto_increment=>true, :type=>:integer, :ruby_default=>nil}], [:description, {:allow_null=>false, :default=>nil, :db_type=>"varchar(500)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>500}], [:date, {:allow_null=>false, :default=>nil, :db_type=>"varchar(30)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>30}], [:Student_id, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}], [:Teacher_id, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}]]],
      [:Student, [:id, :name, :surname],[[:id, {:allow_null=>false, :default=>nil, :db_type=>"integer", :primary_key=>true, :auto_increment=>true, :type=>:integer, :ruby_default=>nil}], [:name, {:allow_null=>false, :default=>nil, :db_type=>"varchar(50)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>50}], [:surname, {:allow_null=>false, :default=>nil, :db_type=>"varchar(50)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>50}]]],
      [:StudentSubject, [:id, :Student_id, :Subject_id],[[:id, {:allow_null=>false, :default=>nil, :db_type=>"integer", :primary_key=>true, :auto_increment=>true, :type=>:integer, :ruby_default=>nil}], [:Student_id, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}], [:Subject_id, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}]]],
      [:Subject, [:id, :name, :Teacher_id],[[:id, {:allow_null=>false, :default=>nil, :db_type=>"integer", :primary_key=>true, :auto_increment=>true, :type=>:integer, :ruby_default=>nil}], [:name, {:allow_null=>false, :default=>nil, :db_type=>"varchar(50)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>50}], [:Teacher_id, {:allow_null=>true, :default=>nil, :db_type=>"integer", :primary_key=>false, :type=>:integer, :ruby_default=>nil}]]],
      [:Teacher, [:id, :name, :surname],[[:id, {:allow_null=>false, :default=>nil, :db_type=>"integer", :primary_key=>true, :auto_increment=>true, :type=>:integer, :ruby_default=>nil}], [:name, {:allow_null=>false, :default=>nil, :db_type=>"varchar(50)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>50}], [:surname, {:allow_null=>false, :default=>nil, :db_type=>"varchar(50)", :primary_key=>false, :type=>:string, :ruby_default=>nil, :max_length=>50}]]],
  ]
  end
  before(:each) do
    Database.init
  end

  it "Checking if tables were created correctly" do
    tables.each do |table|
      expect(Database.db.table_exists?(table[0])).to be_truthy
    end
  end

  it "Checking if tables contains columns" do
    tables.each do |table|
      column_names = []
      Database.db.schema(table[0]).each do |column|
        column.each do |value|
          if value.is_a? Symbol
            column_names << value
          end
        end
      end
      expect(column_names).to match_array(table[1])
    end
  end

  it "Checking if columns contains exact properties" do
    tables.each do |table|
      expect(Database.db.schema(table[0])).to match_array(table[2])
    end
  end

  after(:each) do
  end

end