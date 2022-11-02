import Danger
import Foundation

let danger = Danger()

// MARK: - Entry Point

var isAllCheckPassed = true
let pullRequest = danger.github.pullRequest

// MARK: - Title

// PRのタイトルに[WIP]が含まれる場合は、作業中なのでfailさせる
if pullRequest.title.contains("[WIP]") {
    fail("Should NOT inclued 'WIP' in your PR title");
}

// PRのタイトルに課題番号が含まれているかどうか(DEV_1-XXX)
if let regex = try? NSRegularExpression(pattern: "DEV_1-[0-9]+", options: NSRegularExpression.Options()),
   let _ = regex.firstMatch(in: pullRequest.title,
                            range: NSMakeRange(0, pullRequest.title.count)) {
    // TODO: 関数に切り出してguard letにすると良い
} else {
    warn("Should include issues number in your PR title")
    isAllCheckPassed = false
}

// MARK: - Settings

// PRにレビュアーが指定されているかどうか
// reviewsは現状取れない？
//if let reviewes = danger.github.pullRequest.reviewers,
//   !reviewes.isEmpty {
//    // TODO: 関数に切り出してguard letにすると良い
//} else {
//    warn("Should select PR reviewes")
//    isAllCheckPassed = false
//}

// PRにassigneesが指定されているかどうか
if let assignees = pullRequest.assignees,
   !assignees.isEmpty {
    // TODO: 関数に切り出してguard letにすると良い
} else {
    warn("Should select PR assignees")
    isAllCheckPassed = false
}

// MARK: - Diff amount

let changedLinesCount = (pullRequest.additions ?? 0) + (pullRequest.deletions ?? 0)
if changedLinesCount > 300 {
    danger.warn("変更量が300行を超えています🐱。PRを分割してください。")
    isAllCheckPassed = false
}

// 変更したファイルの数が10より多いかどうか
let chandedFilesCount = pullRequest.changedFiles ?? 0
if chandedFilesCount > 10 {
    warn("Should reduce change files less than 10")
    isAllCheckPassed = false
}

// MARK: - Result

if isAllCheckPassed {
    markdown("## All checkes have passed :tada:")
}

/*

// ===== Branch =====

checkBranchNames(danger.github.pr.head.ref, danger.github.pr.base.ref)

*/

