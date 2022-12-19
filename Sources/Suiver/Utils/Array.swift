extension Array {
    func get(_ index: Int) -> Element? {
        guard index < self.count else { return nil }
        return self[index]
    }
}
