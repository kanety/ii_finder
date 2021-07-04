describe IIFinder::Base do
  context 'initialize' do
    let :finder do
      UsersFinder
    end

    context 'with relation' do
      it 'finds records' do
        expect(finder.call(User.all, id: 1).size).to eq(1)
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
      UsersFinder
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

  context 'properties' do
    let :finder do
      UsersFinder.new(id: 1)
    end

    it 'gets relation' do
      expect(finder.relation).to be_a_kind_of(ActiveRecord::Relation)
    end

    it 'gets table' do
      expect(finder.table).to eq(User.arel_table)
    end

    it 'gets criteria' do
      expect(finder.criteria).to eq(id: 1)
    end
  end
end
