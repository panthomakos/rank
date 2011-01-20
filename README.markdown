# Rank

Easily add rankings to arrays of objects.

## Installation

    gem install rank

## Getting Started

Add rankings to your objects:

    things = [{:attr => 'a'}, {:attr => 'c'}, {:attr => 'b'}]
    Rank.add things, :attr
    => [{:attr=>"a", :rank=>1}, {:attr=>"b", :rank=>2}, {:attr=>"c", :rank=>3}]
    
You can add rank to ActiveRecord objects as well:

    Rank.add User.all, :firstname, :lastname
    
In general anything that responds to '[]' can have a rank added to it.

## Additional Options

Adding a sorting order:
    
    Rank.add User.all, [:firstname, :asc], [:lastname, :desc]
    
You can specify a conversion to floating point or integer:

    Rank.add User.all, [:id, :asc, :integer]
        
You can choose to honor ties or to ignore them:

    things = [{:attr => 'a'}, {:attr => 'c'}, {:attr => 'b'}, {:attr => 'b'}]
    
    Rank.add things, :attr, :ties => false
    => [{:attr=>"a", :rank=>1}, {:attr=>"b", :rank=>2}, {:attr=>"b", :rank=>3}, {:attr=>"c", :rank=>4}]
    
    Rank.add things, :attr, :ties => true
    => [{:attr=>"a", :rank=>1}, {:attr=>"b", :rank=>2}, {:attr=>"b", :rank=>2}, {:attr=>"c", :rank=>4}]
    
You can leave the objects in their original positions:

    things = [{:attr => 'a'}, {:attr => 'c'}, {:attr => 'b'}]
    Rank.add things, :attr, :sort => false
    [{:attr=>"a", :rank=>1}, {:attr=>"c", :rank=>2}, {:attr=>"b", :rank=>2}]