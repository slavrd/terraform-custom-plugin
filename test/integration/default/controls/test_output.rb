control 'test_output' do

  title 'Check output IP'

  describe attribute('external_ip') do
    it { should_not cmp "" }
    it { should_not cmp "127.0.0.1" }
  end

end
