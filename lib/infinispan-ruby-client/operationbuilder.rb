# This class is in charge of creating hot rod operations and populate it with the correct header
# It depends on HeaderBuilder
class OperationBuilder
  def initialize rm
    @remotecache = rm
  end
  def buildGET()
    op = Operation.new(@remotecache)
    op.header=HeaderBuilder.getHeader(GET[0].chr)
    op
  end
end
