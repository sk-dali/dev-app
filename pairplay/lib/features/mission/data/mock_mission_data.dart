import '../../../shared/models/mission.dart';

final List<Mission> mockMissions = [
  // 遊園地カテゴリ
  const Mission(
    id: 'park_1',
    placeCategory: '遊園地',
    title: 'ジェットコースターで手を繋ぐ',
    description: '怖いけど、一緒に手を繋いで乗ってみよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'park_2',
    placeCategory: '遊園地',
    title: '観覧車で写真を撮る',
    description: '一番高いところで記念写真を撮ろう',
    difficulty: 1,
  ),
  const Mission(
    id: 'park_3',
    placeCategory: '遊園地',
    title: 'お化け屋敷で先頭を歩く',
    description: '怖がっている相手を守る役をしよう',
    difficulty: 3,
  ),
  const Mission(
    id: 'park_4',
    placeCategory: '遊園地',
    title: '一緒にメリーゴーランドに乗る',
    description: '子供の頃を思い出しながら楽しもう',
    difficulty: 1,
  ),
  const Mission(
    id: 'park_5',
    placeCategory: '遊園地',
    title: '絶叫マシンで叫び合う',
    description: '恥ずかしがらずに思いっきり叫んでみよう',
    difficulty: 2,
  ),

  // カフェカテゴリ
  const Mission(
    id: 'cafe_1',
    placeCategory: 'カフェ',
    title: 'お互いの好みのドリンクを注文する',
    description: '相手の好みを覚えているか試してみよう',
    difficulty: 1,
  ),
  const Mission(
    id: 'cafe_2',
    placeCategory: 'カフェ',
    title: '一緒にデザートをシェアする',
    description: '一つのデザートを二人で分け合おう',
    difficulty: 1,
  ),
  const Mission(
    id: 'cafe_3',
    placeCategory: 'カフェ',
    title: 'ラテアートを写真に収める',
    description: '綺麗なラテアートを見つけて撮影しよう',
    difficulty: 1,
  ),
  const Mission(
    id: 'cafe_4',
    placeCategory: 'カフェ',
    title: '30分間スマホを見ない',
    description: 'お互いの会話に集中しよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'cafe_5',
    placeCategory: 'カフェ',
    title: '相手の分も注文してみる',
    description: '相手の好みを予想して注文してみよう',
    difficulty: 2,
  ),

  // 公園カテゴリ
  const Mission(
    id: 'park_area_1',
    placeCategory: '公園',
    title: '一緒にブランコに乗る',
    description: '隣同士でブランコを漕いでみよう',
    difficulty: 1,
  ),
  const Mission(
    id: 'park_area_2',
    placeCategory: '公園',
    title: 'ピクニックを計画する',
    description: 'お弁当を持って公園でランチしよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'park_area_3',
    placeCategory: '公園',
    title: '一緒に散歩する',
    description: '30分以上、手を繋いで散歩しよう',
    difficulty: 1,
  ),
  const Mission(
    id: 'park_area_4',
    placeCategory: '公園',
    title: '花の写真を撮る',
    description: '季節の花を見つけて一緒に写真を撮ろう',
    difficulty: 1,
  ),
  const Mission(
    id: 'park_area_5',
    placeCategory: '公園',
    title: 'ベンチで座って会話する',
    description: '1時間以上、深い会話をしよう',
    difficulty: 2,
  ),

  // その他カテゴリ
  const Mission(
    id: 'other_1',
    placeCategory: 'その他',
    title: '一緒に料理を作る',
    description: '協力して一つの料理を完成させよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'other_2',
    placeCategory: 'その他',
    title: '映画館で手を繋ぐ',
    description: '映画を見ながら手を繋いでいよう',
    difficulty: 1,
  ),
  const Mission(
    id: 'other_3',
    placeCategory: 'その他',
    title: '一緒に買い物をする',
    description: '相手の好みを考えながら買い物しよう',
    difficulty: 1,
  ),

  // カラオケカテゴリ
  const Mission(
    id: 'karaoke_1',
    placeCategory: 'カラオケ',
    title: 'デュエット曲を歌う',
    description: '二人で一緒に歌える曲を選んで歌おう',
    difficulty: 1,
  ),
  const Mission(
    id: 'karaoke_2',
    placeCategory: 'カラオケ',
    title: '相手の好きな曲を歌う',
    description: '相手がリクエストした曲を歌ってみよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'karaoke_3',
    placeCategory: 'カラオケ',
    title: '恥ずかしい曲に挑戦する',
    description: '普段は歌わないような曲を思い切って歌おう',
    difficulty: 3,
  ),
  const Mission(
    id: 'karaoke_4',
    placeCategory: 'カラオケ',
    title: '一緒にダンスしながら歌う',
    description: '歌いながら簡単なダンスをしてみよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'karaoke_5',
    placeCategory: 'カラオケ',
    title: 'お互いの歌を録画する',
    description: '相手の歌っている姿を動画で撮影しよう',
    difficulty: 1,
  ),

  // ショッピングカテゴリ
  const Mission(
    id: 'shopping_1',
    placeCategory: 'ショッピング',
    title: '相手の好みを予想して選ぶ',
    description: '相手が好きそうなアイテムを選んでみよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'shopping_2',
    placeCategory: 'ショッピング',
    title: '一緒に試着する',
    description: 'お互いの試着姿を見せ合おう',
    difficulty: 1,
  ),
  const Mission(
    id: 'shopping_3',
    placeCategory: 'ショッピング',
    title: '相手にプレゼントを選ぶ',
    description: '相手の喜ぶ顔を想像しながら選ぼう',
    difficulty: 2,
  ),
  const Mission(
    id: 'shopping_4',
    placeCategory: 'ショッピング',
    title: '一緒にコーディネートを考える',
    description: 'お互いのコーディネートを提案し合おう',
    difficulty: 2,
  ),
  const Mission(
    id: 'shopping_5',
    placeCategory: 'ショッピング',
    title: '予算内でお互いのアイテムを選ぶ',
    description: '決まった予算でお互いのアイテムを選んでみよう',
    difficulty: 3,
  ),

  // 水族館、動物園カテゴリ
  const Mission(
    id: 'aquarium_zoo_1',
    placeCategory: '水族館、動物園',
    title: 'お気に入りの生き物を見つける',
    description: 'お互いのお気に入りの生き物を教え合おう',
    difficulty: 1,
  ),
  const Mission(
    id: 'aquarium_zoo_2',
    placeCategory: '水族館、動物園',
    title: '一緒に写真を撮る',
    description: '生き物を背景に記念写真を撮ろう',
    difficulty: 1,
  ),
  const Mission(
    id: 'aquarium_zoo_3',
    placeCategory: '水族館、動物園',
    title: '触れ合いコーナーで一緒に体験する',
    description: '生き物と触れ合えるコーナーで一緒に体験しよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'aquarium_zoo_4',
    placeCategory: '水族館、動物園',
    title: 'ショーやイベントを一緒に見る',
    description: 'イルカショーや動物のショーを一緒に楽しもう',
    difficulty: 1,
  ),
  const Mission(
    id: 'aquarium_zoo_5',
    placeCategory: '水族館、動物園',
    title: '生き物の名前を覚えるゲーム',
    description: 'お互いに生き物の名前を当てるゲームをしよう',
    difficulty: 2,
  ),

  // 季節のお題カテゴリ
  const Mission(
    id: 'season_1',
    placeCategory: '季節のお題',
    title: 'クリスマスツリーの前で写真を撮る',
    description: 'クリスマスツリーを背景に記念写真を撮ろう',
    difficulty: 1,
  ),
  const Mission(
    id: 'season_2',
    placeCategory: '季節のお題',
    title: 'お正月の初詣に行く',
    description: '一緒に初詣に行って今年の願い事をしよう',
    difficulty: 1,
  ),
  const Mission(
    id: 'season_3',
    placeCategory: '季節のお題',
    title: 'ハロウィンのコスプレをする',
    description: 'お互いにコスプレをしてハロウィンを楽しもう',
    difficulty: 2,
  ),
  const Mission(
    id: 'season_4',
    placeCategory: '季節のお題',
    title: '季節のイベントに参加する',
    description: '花火大会やお祭りなど、季節のイベントを楽しもう',
    difficulty: 1,
  ),
  const Mission(
    id: 'season_5',
    placeCategory: '季節のお題',
    title: '季節限定メニューを一緒に食べる',
    description: 'クリスマスケーキやおせちなど、季節の食べ物を楽しもう',
    difficulty: 1,
  ),

  // お家デートカテゴリ
  const Mission(
    id: 'home_1',
    placeCategory: 'お家デート',
    title: '一緒に料理を作る',
    description: '協力して一つの料理を完成させよう',
    difficulty: 2,
  ),
  const Mission(
    id: 'home_2',
    placeCategory: 'お家デート',
    title: '一緒に映画を見る',
    description: 'お互いが選んだ映画を交互に見よう',
    difficulty: 1,
  ),
  const Mission(
    id: 'home_3',
    placeCategory: 'お家デート',
    title: '一緒にゲームをする',
    description: 'ボードゲームやテレビゲームで楽しもう',
    difficulty: 1,
  ),
  const Mission(
    id: 'home_4',
    placeCategory: 'お家デート',
    title: '一緒に読書タイム',
    description: '静かに本を読みながら、同じ空間で過ごそう',
    difficulty: 1,
  ),
  const Mission(
    id: 'home_5',
    placeCategory: 'お家デート',
    title: '一緒に掃除や片付けをする',
    description: '協力して部屋をきれいにしよう',
    difficulty: 2,
  ),
];

