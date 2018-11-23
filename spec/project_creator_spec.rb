#! /usr/bin/env ruby
# Author: Xan


RSpec.describe ProjectCreator do
	describe "資料夾建立" do
		it "如果資料夾不存在，就建立資料夾。"
		it "如果資料夾存在，就不建立資料夾。"
	end

	describe "領錢功能" do
		it "原本帳戶有 10 元，領出 5 元之後，帳戶餘額變 5 元"
		it "原本帳戶有 10 元，試圖領出 20 元，帳戶餘額還是 10 元，但無法領出（餘額不足）"
		it "原本帳戶有 10 元，領出 -5 元之後，帳戶餘額還是 10 元（不能領出小於或等於零的金額）"
	end
end
