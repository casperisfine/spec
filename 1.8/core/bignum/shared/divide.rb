shared :bignum_divide do |cmd|
  describe "Bignum##{cmd}" do
    before(:each) do
      @bignum = bignum_value(88)
    end
    
    it "returns self divided by other" do
      @bignum.send(cmd, 4).should == 2305843009213693974

      @bignum.send(cmd, 0xffff_ffff.to_f).should be_close(2147483648.5, TOLERANCE)
      @bignum.send(cmd, bignum_value(2)).should be_close(1, TOLERANCE)
      
      (-(10**50)).send(cmd, -(10**40 + 1)).should == 9999999999
      (10**50).send(cmd, 10**40 + 1).should == 9999999999

      (-10**50).send(cmd, 10**40 + 1).should == -10000000000
      (10**50).send(cmd, -(10**40 + 1)).should == -10000000000
    end

    it "raises a ZeroDivisionError if other is zero and not a Float" do
      lambda { @bignum.send(cmd, 0) }.should raise_error(ZeroDivisionError)
    end

    it "does NOT raise ZeroDivisionError if other is zero and is a Float" do
      @bignum.send(cmd, 0.0).to_s.should == 'Infinity'
      @bignum.send(cmd, -0.0).to_s.should == '-Infinity'
    end

    it "raises a TypeError when given a non-Integer" do
      lambda {
        (obj = mock('10')).should_receive(:to_int).any_number_of_times.and_return(10)
        @bignum.div(obj)
      }.should raise_error(TypeError)
      lambda { @bignum.div("2") }.should raise_error(TypeError)
    end
  end
end
