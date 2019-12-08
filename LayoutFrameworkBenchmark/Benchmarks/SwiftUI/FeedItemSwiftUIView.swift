//
//  FeedItemSwiftUIView.swift
//  LayoutFrameworkBenchmark
//
//  Created by Tran Duc on 12/7/19.
//

import UIKit
import SwiftUI

@available(iOS 13.0.0, *)
class FeedItemSwiftUIView: UIView, DataBinder {

    lazy var feedItem = FeedItemDataWrapper(data: FeedItemData())
    lazy var childViewController = UIHostingController(rootView: SUIViewContent(feedItem: feedItem))

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        childViewController.view.translatesAutoresizingMaskIntoConstraints = true
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.view.frame = self.bounds
        addSubview(childViewController.view)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(_ data: FeedItemData) {
        feedItem.data = data
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return childViewController.sizeThatFits(in: size)
    }
}

@available(iOS 13.0.0, *)
final class FeedItemDataWrapper: ObservableObject {
    @Published var data: FeedItemData

    init(data: FeedItemData) {
        self.data = data
    }
}

@available(iOS 13.0.0, *)
struct SUIViewContent: View {
    @ObservedObject var feedItem: FeedItemDataWrapper

    var body: some View {
        VStack(alignment: .leading) {
            SUITopBarView(feedItem: feedItem)
            SUIPosterCard(feedItem: feedItem)
            Text(feedItem.data.posterComment)
            Image("350x200")
            Text(feedItem.data.contentTitle)
            Text(feedItem.data.contentDomain)
            SUIActions()
            SUIComment(feedItem: feedItem)
        }.padding()
    }
}

@available(iOS 13.0.0, *)
fileprivate struct SUITopBarView: View {
    @ObservedObject var feedItem: FeedItemDataWrapper
    var body: some View {
        HStack {
            Text(feedItem.data.actionText)
            Spacer()
            Text("...")
        }
    }
}

@available(iOS 13.0.0, *)
fileprivate struct SUIPosterCard: View {
    @ObservedObject var feedItem: FeedItemDataWrapper
    var body: some View {
        HStack {
            Image("50x50")
            VStack(alignment: .leading) {
                Text(feedItem.data.posterName).background(Color.yellow)
                Text(feedItem.data.posterHeadline).lineLimit(3)
                Text(feedItem.data.posterTimestamp).background(Color.yellow)
            }
        }
    }
}

@available(iOS 13.0.0, *)
fileprivate struct SUIActions: View {
    var body: some View {
        HStack {
            Text("Like").background(Color.green)
            Spacer()
            Text("Comment").background(Color.green)
            Spacer()
            Text("Share").background(Color.green)
        }
    }
}

@available(iOS 13.0.0, *)
fileprivate struct SUIComment: View {
    @ObservedObject var feedItem: FeedItemDataWrapper
    var body: some View {
        HStack {
            Image("50x50")
            Text(feedItem.data.actorComment)
        }
    }
}

