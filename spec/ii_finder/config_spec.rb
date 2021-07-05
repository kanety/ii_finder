describe IIFinder::Config do
  context 'configure' do
    before do
      IIFinder.configure do |config|
        config.lookup_cache = false
      end
    end

    after do
      IIFinder.configure do |config|
        config.lookup_cache = true
      end
    end

    it 'gets and sets' do
      expect(IIFinder.config.lookup_cache).to eq(false)
    end
  end
end
