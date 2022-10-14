class NotifyVotingService
  include ServiceBase

  def call
    date = Time.zone.today

    # TODO:
    # メール送信のテンプレートみたいに文言を持ちたい（ここにベタ書きをしたくない）
    text = "*😎 VOTING INFORMATION*\n"
    # TODO:
    # ここで公式サイトのURL構造の知識を持たない
    # rubocop:disable Layout/LineLength
    text += "SP: https://www.boatrace.jp/owsp/sp/race/raceindex?hd=#{date.strftime('%Y%m%d')}&jcd=#{format('%02d', stadium_tel_code)}##{race_number}\n"
    text += "PC: https://boatrace.jp/owpc/pc/race/racelist?rno=#{race_number}&jcd=#{format('%02d', stadium_tel_code)}&hd=#{date.strftime('%Y%m%d')}\n"
    # rubocop:enable Layout/LineLength
    text += "\n"
    text += "Below odds have been voted.\n"
    odds.each do |odds|
      text += "#{odds[:number]} * #{odds[:quantity]}\n"
    end

    # TODO:
    # Slack以外の通知手段にも対応することになった時点で抽象化する
    # チャンネル名は定数で持つ
    slack_client = Slack::Web::Client.new
    response = slack_client.chat_postMessage(channel: '#777_boatrace_betting', text: text, mrkdwn: true)
    response.ok
  end

  private

  attr_accessor :stadium_tel_code, :race_number, :odds
end
