describe IIFinder::Callbacks do
  context 'before' do
    [Callbacks::BeforeAllFinder, Callbacks::BeforeCallFinder].each do |finder|
      context finder do
        it 'calls callback' do
          expect(finder.call.size).to eq(1)
        end
      end
    end
  end

  context 'after' do
    [Callbacks::AfterAllFinder, Callbacks::AfterCallFinder].each do |finder|
      context finder do
        it 'calls callback' do
          expect(finder.call.size).to eq(1)
        end
      end
    end
  end

  context 'around' do
    [Callbacks::AroundAllFinder, Callbacks::AroundCallFinder].each do |finder|
      context finder do
        it 'calls callback' do
          expect(finder.call.size).to eq(1)
        end
      end
    end
  end
end
