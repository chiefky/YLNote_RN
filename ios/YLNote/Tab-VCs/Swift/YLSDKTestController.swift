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
class YLSDKTestController: UIViewController {
    
    let cellIdentifier = "kYLSDKTableViewCell"
    
    //    var data:[String]?
    //    var adIndexs = [0,2,4,9]
    var layoutFrame:CGRect = .zero
    var visualView:UIView?
    var viewModel:YLNewsViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(view.frame)
        visualView = view
        self.navigationController?.navigationBar.isTranslucent = false
        self.tabBarController?.tabBar.isTranslucent = false
        self.edgesForExtendedLayout = [];
        self.tabBarController?.edgesForExtendedLayout = [];//为了view不在tabBarController下
        
        self.view.layoutIfNeeded()
        // 获取根视图的 frame
        let rootViewFrame = self.view.frame
        print(rootViewFrame)
        
        self.tableView.register(UINib(nibName: String(describing: YLActorTableViewCell.self), bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.register(YLAdSmallCell.self, forCellReuseIdentifier: YLAdSmallCell.cellIdentifier)
        self.tableView.register(YLAdBigCell.self, forCellReuseIdentifier: YLAdBigCell.cellIdentifier)
        self.tableView.register(YLAdThreeCell.self, forCellReuseIdentifier: YLAdThreeCell.cellIdentifier)
        //        self.tableView.register(YLAdGifCell.self, forCellReuseIdentifier: YLAdGifCell.cellIdentifier)
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutFrame = view.frame
        if #available(iOS 11.0, *) {
            layoutFrame = view.safeAreaLayoutGuide.layoutFrame
            visualView = UIView(frame: layoutFrame)
        }
        requestDatas()
        
    }
    
    
    // MARK: - Navigation
    func requestDatas() {
        
        DispatchQueue.global().async {
            let path = Bundle.main.path(forResource: "Actors", ofType: "json")
            let url = URL(fileURLWithPath: path!)
            do {
                let json = try Data.init(contentsOf: url)
                //                let bytes: [UInt8] = [UInt8](json)
                //                print(bytes.count)
                //                let jsonData = try JSONSerialization.jsonObject(with: json)
                let data = try JSONDecoder().decode([Actor].self, from: json)
                let actors = data.map {
                    Actor(id: $0.id,name: $0.name, avatar:$0.avatar)
                };
                // 示例用法
                let ads:[YLAdProtocol] = [YLAdBig(adId: "big0", imageUrl: ""),YLAdSmall(adId: "small0",imageUrl: "", title: "小图"),YLAdThree(adId: "9",adLink: "", adImages: ["1","2","3"])]
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
        table.backgroundColor = .systemTeal
        return table
    }()
}

extension YLSDKTestController:UITableViewDelegate,UITableViewDataSource {
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

extension YLSDKTestController {
    // 监听滚动事件
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 获取 tableView 的可见区域高度
        let visibleCells = tableView.visibleCells;
        print("-------------")
        for  cell in visibleCells {
            // 只对可视区的广告cell进行处理
            if cell is YLAdCellProtocol {
                let cellHeight = cell.bounds.height
                let cellPoint = cell.frame.origin
//                let cellInWindowPoint = tableView.convert(cellPoint, to: self.view) //(ios 16 以后)
                let cellInWindowPoint = tableView.convert(cellPoint, to: self.view.coordinateSpace) // (ios 8以后）
                let cellBottomY = cellInWindowPoint.y + cellHeight
                let cellTopY = cellInWindowPoint.y
                var showHeight = 0.0
                if let indexPath = tableView.indexPath(for: cell),var cellModel = self.viewModel?.allCellModels[safe: indexPath.row] as? YLAdCellModelProtocol {
//                    let isVisible = cell.isViewVisible(exposureRatio: 0.5, to: self.view.coordinateSpace)
                    if cellTopY < 0 {
                        // 顶部滑出屏幕一半
                        showHeight = cellHeight - abs(cellTopY)

                    } else if cellBottomY > self.view.bounds.height {
                        // 底部滑出屏幕一半
                        showHeight = self.view.bounds.height - cellTopY

                    } else {
                        // 在屏幕内
                        showHeight = cellHeight
                    }
                    let percentageVisible = showHeight / cellHeight
                    let realRate = String(format: "%.2f", percentageVisible*100)
                    print("\(indexPath.row):[\(showHeight)],[\(cellInWindowPoint)],\(realRate)")
                    
                    if percentageVisible > 0.5 && !cellModel.exposure {
                        print("♥♥♥♥♥♥♥♥♥♥♥♥♥♥Beign♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥")
                        print("可视区广告满足条件：曝光,开始统计时长")
                        print("♥♥♥♥♥♥♥♥♥♥♥♥♥♥End♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥")
                        cellModel.change(exposure: true)
                    }
                    
                }
            }
        }
        print("-------------\n")
        
        // 获取当前滚动的偏移量
        //        let yOffset = tableView.contentOffset.y
        //
        //        if let bottomCell = visibleCells.last, var adCell = bottomCell as? YLAdCellProtocol {
        //            let cellHeight = bottomCell.bounds.height
        //            let cellPoint = bottomCell.frame.origin
        //            let cellInWindowPoint = tableView.convert(cellPoint, to: self.view)
        //            let cellTopY = cellInWindowPoint.y
        //            let percentageVisible = (self.view.bounds.height - cellTopY) / cellHeight
        //            let realRate = String(format: "%.2f", percentageVisible*100)
        //            if percentageVisible > 0.5 && !adCell.exposure {
        //                print("♥♥♥♥♥♥♥♥♥♥♥♥♥♥Beign♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥")
        //                print("底部广告：超过\(realRate) 曝光,开始统计时长")
        //                adCell.exposure = true
        //                print("♥♥♥♥♥♥♥♥♥♥♥♥♥♥End♥♥♥♥♥♥♥♥♥♥♥♥♥♥♥")
        //
        //            } else {
        //
        //            }
        //        }
        
    }
    
    
}
