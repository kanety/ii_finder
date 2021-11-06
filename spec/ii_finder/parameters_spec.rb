describe IIFinder::Parameters do
  context 'allow_blank' do
    let :finder do
      Parameters::AllowBlankItemsFinder
    end

    it 'finds records' do
      expect(finder.call(name: '').size).to eq(0)
    end
  end
end
