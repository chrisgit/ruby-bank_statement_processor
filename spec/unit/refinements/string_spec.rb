using StringRefinements

describe StringRefinements do
  describe 'Tesco' do
    it 'matches 15062017 Tesco Pay At Pump' do
      expect('Tesco'.within?('15062017 Tesco Pay At Pump')).to be true
    end
  end
  describe 'Tesco but not Pay At Pump' do
    it 'does not match 15062017 Tesco Pay At Pump Eastleigh' do
      expect('Tesco'.but_not('Pay at pump').within?('15062017 Tesco Pay At Pump')).to be false
    end
  end

  describe 'Tesco , Homestores' do
    it 'matches 15062017 Tesco-Stores , Homestores London SW1' do
      expect('Tesco'.when_matches_with('Tesco-Stores , Homestores').within?('15062017 Tesco-Stores , Homestores London SW1')).to be true
    end
  end
end