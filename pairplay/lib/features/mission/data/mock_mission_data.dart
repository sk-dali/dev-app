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
];

