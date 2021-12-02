describe IIFinder::Callbacks do
  context 'before' do
    [Callbacks::BeforeFinder, Callbacks::BeforeAssignFinder].each do |finder|
      context finder do
        it 'calls callback' do
          expect(finder.call.size).to eq(1)
        end
      end
    end
  end

  context 'after' do
    [Callbacks::AfterFinder, Callbacks::AfterAssignFinder].each do |finder|
      context finder do
        it 'calls callback' do
          expect(finder.call.size).to eq(1)
        end
      end
    end
  end

  context 'around' do
    [Callbacks::AroundFinder, Callbacks::AroundAssignFinder].each do |finder|
      context finder do
        it 'calls callback' do
          expect(finder.call.size).to eq(1)
        end
      end
    end
  end
end
