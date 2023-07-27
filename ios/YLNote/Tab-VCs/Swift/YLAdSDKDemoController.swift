//
//  YLSDKTestController.swift
//  YLNote
//
//  Created by tangh on 2023/7/21.
//  Copyright © 2023 tangh. All rights reserved.
//

import UIKit
import SDWebImage

struct Actor:Codable {
    var id:String
    var name:String
    var avatar:String = ""
    //    init(id:String) {
    //        self.id = id
    //    }
}
class YLAdSDKDemoController: UIViewController {
    
    let cellIdentifier = "kYLActorTableViewCell"
    var viewModel:YLNewsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏、tabbar不透明，直接后果是改变了self.view的frame也就是可视窗口的区域
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
        self.edgesForExtendedLayout = [];
        self.tabBarController?.edgesForExtendedLayout = [];//为了view不在tabBarController下
        
        self.tableView.register(UINib(nibName: String(describing: YLActorTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.register(YLAdSmallCell.self, forCellReuseIdentifier: YLAdSmallCell.cellIdentifier)
        self.tableView.register(YLAdBigCell.self, forCellReuseIdentifier: YLAdBigCell.cellIdentifier)
        self.tableView.register(YLAdThreeCell.self, forCellReuseIdentifier: YLAdThreeCell.cellIdentifier)
        self.tableView.register(YLAdGifCell.self, forCellReuseIdentifier: YLAdGifCell.cellIdentifier)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestDatas()
        
    }
    
    
    // MARK: - Navigation
    func requestDatas() {
        
        DispatchQueue.global().async {
            guard let path = Bundle.main.path(forResource: "Actors", ofType: "json") else {return}
            let url = URL(fileURLWithPath: path)
            do {
                let json = try Data.init(contentsOf: url)
                let data = try JSONDecoder().decode([Actor].self, from: json)
                let actors = data.map {
                    Actor(id: $0.id,name: $0.name, avatar:$0.avatar)
                };
                // 示例用法
                let ads:[YLAdProtocol] = [YLAdBig(adId: "big0", imageUrl: "https://www.hurex.jp/wp/wp-content/uploads/2020/11/kyoto_company.png"),YLAdSmall(adId: "small0",imageUrl: "https://img.activityjapan.com/wi/kyoto-tourist-spot_top01.jpg", title: "京都觀光示範路線| 一日遊及推薦景點| Activity Japan"),YLAdThree(adId: "9",adLink: "", adImages: ["https://img.activityjapan.com/wi/kyoto_autumn_001.jpg","https://i0.wp.com/www.agoda.com/wp-content/uploads/2020/02/Kyoto-attractions-Kiyomizu-Temple.jpg?ssl=1","https://image.hldy-cdn.com/c/w=1336,h=826,g=5,a=2,r=auto,f=webp:auto/holiday_article_images/4709/4709.jpg?1592537784"])]
                let reverse = actors.reversed()
                let allActors = actors + reverse
                let positions = [1, 6, 9]
                let model = YLNews(ads: ads, actors: allActors, position: positions)
                self.viewModel = YLNewsViewModel(model: model)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error as Error? {
                print("读取本地数据出现错误!",error as Any)
            }
        }
    }
    
    
    
    // MARK: lazy
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 90
        table.backgroundColor = .systemBackground
        return table
    }()
}

extension YLAdSDKDemoController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel,let data = viewModel.allCellModels[safe: indexPath.row] else { return UITableViewCell() }
        if let adData = data as? YLAdCellModelProtocol {
            switch adData.type {
            case .small:
                let adCell = YLAdSmallCell.dequeueReusableCell(from: tableView, for: indexPath)
                adCell.configure(with: adData)
                return adCell
            case .big:
                let adCell = YLAdBigCell.dequeueReusableCell(from: tableView, for: indexPath)
                adCell.configure(with: adData)
                return adCell
            case .three:
                let adCell = YLAdThreeCell.dequeueReusableCell(from: tableView, for: indexPath)
                adCell.configure(with: adData)
                return adCell
            case .gif:
                let adCell = YLAdGifCell.dequeueReusableCell(from: tableView, for: indexPath)
                adCell.configure(with: adData)
                return adCell
            case .video(picBig: true):
                let adCell = YLAdVideoBigCell.dequeueReusableCell(from: tableView, for: indexPath)
                adCell.configure(with: adData)
                return adCell
            case .video(picBig: false):
                let adCell = YLAdVideoSmallCell.dequeueReusableCell(from: tableView, for: indexPath)
                adCell.configure(with: adData)
                return adCell
            }
        } else if let actor = data as? YLActorCellModel {
            if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? YLActorTableViewCell {
                cell.txtLabel.text = "\(indexPath.row)" + actor.name
                cell.picView.sd_setImage(with: URL(string: actor.avatar))
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.allCellModels.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard cell is YLAdCellProtocol else { return }
        let cellPoint = cell.frame.origin
        let cellInWindowPoint = tableView.convert(cellPoint, to: self.view)
        let cellTopY = cellInWindowPoint.y
        let cellBottomY = cellInWindowPoint.y + cell.bounds.height
        
        if cellTopY >= 0 && cellBottomY <= self.view.bounds.height {
            print("---------Begin--------")
            if var cellModel = self.viewModel?.allCellModels[safe: indexPath.row] as? YLAdCellModelProtocol {
                cellModel.change(exposure: true)
            }
            print("\(indexPath.row) 广告： 100%展示,统计时长")
            print("---------End--------\n")
        }
    }
    
}

extension YLAdSDKDemoController {
    // 监听滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取 tableView 的可见区域高度
        let visibleCells = tableView.visibleCells;
        for  cell in visibleCells {
            // 只对可视区的广告cell进行处理
            if cell is YLAdCellProtocol {
                if let indexPath = tableView.indexPath(for: cell),var cellModel = self.viewModel?.allCellModels[safe: indexPath.row] as? YLAdCellModelProtocol {
                    let isVisible = cell.isViewVisible(exposureRatio: 0.5, to: self.view.coordinateSpace) // 广告自动监测逻辑-->是否满足曝光条件
                    if isVisible && !cellModel.exposure {
                        print("♥♥♥♥♥♥♥♥♥♥♥♥♥♥Beign♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥")
                        print("可视区广告满足条件：曝光,开始统计时长")
                        print("♥♥♥♥♥♥♥♥♥♥♥♥♥♥End♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥")
                        cellModel.change(exposure: true)
                    }
                    
                }
            }
        }
    }
    
    
}
