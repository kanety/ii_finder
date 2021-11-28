describe IIFinder::Config do
  context 'configure' do
    before do
      IIFinder.configure do |config|
        config.merge_relation = false
      end
    end

    after do
      IIFinder.configure do |config|
        config.merge_relation = true
      end
    end

    it 'gets and sets' do
      expect(IIFinder.config.merge_relation).to eq(false)
    end
  end
end
