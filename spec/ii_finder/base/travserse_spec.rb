describe IIFinder::Base do
  before do
    @traversal = IIFinder.config.traversal
  end

  after do
    IIFinder.config.traversal = @traversal
  end

  context 'preorder' do
    before do
      IIFinder.config.traversal = :preorder
    end

    let :finder_klass do
      CoactiveItemFinder
    end

    it 'traverses preorder' do
      finder = finder_klass.new.tap(&:call_all)
      expect(finder.context.results).to eq(['Main', 'Name', 'Age'])
    end
  end

  context 'postorder' do
    before do
      IIFinder.config.traversal = :postorder
    end

    let :finder_klass do
      CoactiveItemFinder
    end

    it 'traverses postorder' do
      finder = finder_klass.new.tap(&:call_all)
      expect(finder.context.results).to eq(['Name', 'Age', 'Main'])
    end
  end

  context 'inorder' do
    before do
      IIFinder.config.traversal = :inorder
    end

    let :finder_klass do
      CoactiveItemFinder
    end

    it 'traverses inorder' do
      finder = finder_klass.new.tap(&:call_all)
      expect(finder.context.results).to eq(['Name', 'Main', 'Age'])
    end
  end
end
