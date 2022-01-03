describe IIFinder::Base do
  context 'initialize' do
    let :finder do
      ItemsFinder
    end

    context 'with relation' do
      it 'finds records' do
        expect(finder.call(Item.all, id: 1).size).to eq(1)
      end
    end

    context 'without relation' do
      it 'finds records' do
        expect(finder.call(id: 1).size).to eq(1)
      end
    end
  end

  context 'call' do
    let :finder do
      ItemsFinder
    end

    context 'criteria with hash' do
      it 'finds records' do
        expect(finder.call(id: 1).size).to eq(1)
      end
    end

    context 'criteria with object' do
      it 'finds records' do
        expect(finder.call(OpenStruct.new(id: 1)).size).to eq(1)
      end
    end
  end

  context 'merge result' do
    let :finder do
      ItemsFinder
    end

    context 'relation' do
      it 'finds records' do
        expect(finder.call(id: 1).size).to eq(1)
      end
    end

    context 'hash' do
      it 'finds records' do
        expect(finder.call(query: { where: { id: 1 } }).size).to eq(1)
      end
    end
  end

  context 'properties' do
    let :finder do
      ItemsFinder.new(id: 1)
    end

    it 'gets relation' do
      expect(finder.context.relation).to be_a_kind_of(ActiveRecord::Relation)
    end

    it 'gets criteria' do
      expect(finder.context.criteria).to eq(id: 1)
    end

    it 'gets model' do
      expect(finder.context.model).to eq(Item)
    end

    it 'gets table' do
      expect(finder.context.table).to eq(Item.arel_table)
    end
  end
end
