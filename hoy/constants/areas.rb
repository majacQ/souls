module Constants
  def self.areas
    # 参考URL 西濃運輸｜カンガルー宅急便運賃表
    # http://stc.deliveryseino.jp/unchin/unchin.20191001.pdf
    {
      "北海道": ["北海道"],
      "北東北": %w[青森 岩手 秋田],
      "南東北": %w[宮城 山形 福島],
      "関東": %w[栃木 群馬 新潟 茨城 千葉 東京 神奈川 山梨],
      "中部": %w[富山 石川 福井 長野 静岡 愛知 三重 岐阜],
      "近畿": %w[滋賀 京都 大阪 奈良 和歌山 兵庫],
      "中国": %w[鳥取 岡山 島根 広島 山口],
      "四国": %w[香川 徳島 愛媛 高知],
      "北九州": %w[福岡 大分 長崎 佐賀],
      "南九州": %w[宮崎 熊本 鹿児島],
      "沖縄": ["沖縄"]
    }
  end

  def self.prefectures
    %w[
      北海道
      青森県
      岩手県
      宮城県
      秋田県
      山形県
      福島県
      茨城県
      栃木県
      群馬県
      埼玉県
      千葉県
      東京都
      神奈川県
      新潟県
      富山県
      石川県
      福井県
      山梨県
      長野県
      岐阜県
      静岡県
      愛知県
      三重県
      滋賀県
      京都府
      大阪府
      兵庫県
      奈良県
      和歌山県
      鳥取県
      島根県
      岡山県
      広島県
      山口県
      徳島県
      香川県
      愛媛県
      高知県
      福岡県
      佐賀県
      長崎県
      熊本県
      大分県
      宮崎県
      鹿児島県
      沖縄県
    ]
  end
end
