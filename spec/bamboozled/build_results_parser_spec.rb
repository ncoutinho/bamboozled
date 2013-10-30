require "bamboozled/build_results_parser"

describe Bamboozled::BuildResultsParser do

  def fixtures
    File.expand_path("../../fixtures", __FILE__)
  end

  def load_fixture(path)
    File.read("#{fixtures}/#{path}")
  end

  let(:results) { Bamboozled::BuildResultsParser.parse(results_json) }

  context "with results for a plan" do

    let(:results_json) { load_fixture("results-PROJECT-PLAN.json") }

    context "for each build" do

      it "extracts an entry" do
        expect(results.map(&:key)).to eq [
          "PROJECT-PLAN-12",
          "PROJECT-PLAN-11",
          "PROJECT-PLAN-10",
          "PROJECT-PLAN-9",
          "PROJECT-PLAN-8"
        ]
      end

      let(:first_result) { results.first }

      it "extracts the status" do
        expect(first_result.status).to eq(:failed)
      end

      context "for each stage" do

        it "extracts an entry" do
          expect(first_result.stages.map(&:name)).to eq [
            "Aminate",
            "Certify Init",
            "Certify Warmup",
            "Certify Test",
            "Certify Tagging",
            "Publish",
            "Promote to Staging",
            "Promote to Production"
          ]
        end

        let(:first_result) { results.first }

        it "extracts the status" do
          expect(first_result.stages.map(&:status)).to eq [
            :successful,
            :successful,
            :successful,
            :failed,
            :unknown,
            :unknown,
            :unknown,
            :unknown
          ]
        end

      end

    end

  end

end