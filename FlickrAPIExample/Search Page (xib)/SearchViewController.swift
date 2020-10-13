//
//  SearchViewController.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/12.
//

import UIKit

// Note: 為範例，這個 VC 用 Xib 來實現。
//       輸入欄位跟按鈕三個元件合併再一起螢幕置中
//       按鈕圓角
//       數字相關的輸入欄位用限制鍵盤的簡單的防呆 (目前沒打算全擋，可以用複製的方式繞過)
class SearchViewController: UIViewController {

    @IBOutlet weak var keywordTextFeild: UITextField!
    @IBOutlet weak var perPageTextFeild: UITextField!
    @IBOutlet weak var searchBtn: UIButton!

    private var endEditGesture: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup
        title = "搜尋頁"
        setupEndEditingGesture()
        updateSearchBtnState()
    }

    private func setupEndEditingGesture() {
        if let gesture = endEditGesture {
            // Reset
            view.removeGestureRecognizer(gesture)
            view.addGestureRecognizer(gesture)
        } else {
            // Create
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleEndEditing))
            view.addGestureRecognizer(gesture)
            endEditGesture = gesture
        }
    }

    private func updateSearchBtnState() {
        // 此兩個輸入匡都要填寫，button才可以點擊
        // 不可點擊的button和可點擊的button用不同顏色區別
        let keywordLength = keywordTextFeild.text?.count ?? 0
        let perPageLength = perPageTextFeild.text?.count ?? 0

        if min(keywordLength, perPageLength) > 0 {
            // Enable
            searchBtn.isEnabled = true
            searchBtn.backgroundColor = .systemBlue
        } else {
            // Disable
            searchBtn.isEnabled = false
            searchBtn.backgroundColor = .gray
        }
    }

    // MARK: - UI Event
    @IBAction func searchBtnTapped(_ sender: Any) {
        if let keyword = keywordTextFeild.text, let perPage = perPageTextFeild.text {
            // Note: 可以加上擋著 UI 的 Loading，這邊單純把事件都擋下來，不詳細處理
            view.isUserInteractionEnabled = false
            FlickrAPI.search(text: keyword, perPage: perPage) {
                [self] (result, response, error) in

                // Note: 不詳細處理 Error 情境
                if let result = result {
                    // Push VC
                    let resultVM = ResultPageViewModel(keyword: keyword, searchResult: result)
                    let resultVC = ResultPageViewController(resultVM: resultVM)
                    navigationController?.pushViewController(resultVC, animated: true)
                }
                view.isUserInteractionEnabled = true
            }
            handleEndEditing()
        } else {
            // Note: 處理沒輸入完整的情境，暫時不多做處理
            print("Error: Invalid Input!!")
        }
    }

    // Note: 因為沒有分辨的需求，兩個 TextFeild 用同一個 function。
    @IBAction func textFeildValueChanged(_ sender: Any) {
        updateSearchBtnState()
    }

    @objc private func handleEndEditing() {
        view.endEditing(true)
    }
}
