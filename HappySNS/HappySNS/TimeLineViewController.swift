//
//  ViewController.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/21.
//

import UIKit
import RAMAnimatedTabBarController
import ViewAnimator

class TimeLineViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var loadDBModel = LoadDBModel()
    //スクロールビューの内容の更新を開始できる標準のコントロール。
    var refreshControl:UIRefreshControl!
    
    let semaphore = DispatchSemaphore(value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
                //可変にしたいとき
                tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "PostContentTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "再読み込み中")
        refreshControl.addTarget(self, action: #selector(TimeLineViewController.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //loadDBModel.loadContents()
        //tableView.reloadData()
        
        let animation = AnimationType.zoom(scale: 0.5)
        
        UIView.animate(views: tableView.visibleCells,
                       animations: [animation],
                       delay: 0.5)
        
    }
    @objc func refresh() {
        updateData()
        
        semaphore.wait()
        //semaphore.signal()
        // データ更新関数が終了したら、リフレッシュの表示も終了する
        refreshControl.endRefreshing()
    }
    func updateData () {
        DispatchQueue.global().async {
            
            //ここでデータを更新する処理をする
            
            DispatchQueue.main.async {
                self.loadDBModel.loadContents()
                self.tableView.reloadData()
                self.semaphore.signal() // 処理が終わった信号を送る
            }
        }
    }
    func textViewDidChange(textView: UITextView) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
extension TimeLineViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 155
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        loadDBModel.dataSets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostContentTableViewCell
        
        
        cell.postTextView.text = loadDBModel.dataSets[indexPath.row].postComment
        //cell.profileImagiView.image = loadDBModel.dataSets[indexPath.row].postImageView
        return cell
        
    }
    
}