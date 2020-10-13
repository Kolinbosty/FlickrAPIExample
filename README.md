### 架構

因為主要為展示，做法跟架構沒有統一，分檔案處理，下面一一說明。

在 Code 內會有留 `// Note: 我是說明` 的註解部分，做比較細節的說明。

- Tabbar
  - root ViewController 沒什麼特別的
- API
  - 用 Codable
  - 用 FlickrAPI+Search 這樣的方式增進未來的擴充性，如果有新加不同 API。
  - Photo 是 Hashable，是為了之後找是否有加入最愛用的。
- Search Page
  - 使用 xib 處理 UI 的部分
  - 對於比較不需要動態處理一些 auto layout 的部分其實會比較方便。
  - TextFeild & Button 三個為一組，都會水平垂直置中，純用 xib 處理。
- PhotoBrowser
  - 用 Code 處理 UI 部分
  - MVVM，對於比較複雜的頁面這樣處理起來彈性比較夠，而且不會雜亂。
  - 因為 最愛頁面 跟 搜尋結果頁 基本上一樣，這邊都繼承 PhotoBrowserViewController。
  - 用上述方式來解少 code 的重複，都是實作 `PhotoBrowserViewModelProtocol` 所以處理有關 cell 跟 update 的部分 parent class 都會處理，不需刻意處理。
  - 然後可以在 `FavPageViewModel` 跟 `ResultPageViewModel` 做出資料的差異，例如 Title 跟 最愛按鈕 是否要顯示的。
- Common (FavCenter)
  - 用最簡單的 UserDefault 來處理存資料的部分
  - 單純是個跟 UserDefault 的介面
  - 用 [Photo: Date] 的資料存起來，用 Photo 當 key 是為了加速搜尋是否有加入最愛，另外存 Date 是為了判別加入的順序，用 Array 跟 Set 也可以個別達到，詳細可以見 Code 內說明。
  - 因為 photo 本身是 hashable 又支援 codable，所以可以直接拿來跟新從 API 的資料來比較是否相同（不過是拿全部的值，不是單純拿 id，這邊不考慮，我不知道 Flickr 是拿其中哪些值做他們的 id，例如換 serverid 到底是不是同一張圖）。

### 環境

MacOS 11.0 beta

Xcode 12.0

iPhone 11 Pro (iOS 14.0)

### ThirdParty Lib

KingFisher: 用來處理 URL 讀取圖片而已

使用 Cocoapods 加入