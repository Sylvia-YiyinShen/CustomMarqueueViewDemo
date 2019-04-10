# A customisable  mar-queue widget
1. custom cell
2. custom size
3. custom scroll direction
4. custom scroll interval



# How to use
1. make your own collection view cell conform to MarqueueViewCellProtocol
2. make your own cell model conform to MarqueueViewCellModelProtocol
3. invoke function marqueueView.configure(models: [MarqueueViewCellModelProtocol], customCellNib: UINib, orientation: Orientation = default, interval: TimeInterval)



![horizontal](https://user-images.githubusercontent.com/46996132/55873783-e33a8100-5bd3-11e9-8023-bbf84e9841d1.gif)
![vertical](https://user-images.githubusercontent.com/46996132/55873785-e46bae00-5bd3-11e9-82ff-f8a793ff4082.gif)
