                VStack(spacing: 12) {
                    TradeTypeToggleView(selectedType: $viewModel.selectedTradeType)
                    
                    OrderTypePickerView(selectedOrderType: $viewModel.selectedOrderType)
                    
                    IncrementDecrementInputView(title: "Price",
                                                value: $viewModel.price,
                                                increment: viewModel.incrementPrice,
                                                decrement: viewModel.decrementPrice)
                    .onChange(of: viewModel.price) { newValue in
                        viewModel.updatePrice(newValue)
                    }

                    IncrementDecrementInputView(title: "Amount (BTC)",
                                                value: $viewModel.amount,
                                                increment: viewModel.incrementAmount,
                                                decrement: viewModel.decrementAmount)
                    .onChange(of: viewModel.amount) { newValue in
                        viewModel.updateAmount(newValue)
                    }

                    TradeSliderView { percent in
                        let balanceForUse = viewModel.availableBalance * (percent / 100)
                        let calculatedAmount = (balanceForUse / viewModel.price).rounded(toPlaces: 5)
                        viewModel.updateAmount(calculatedAmount)
                    }
                    
                    TotalInputView(title: "Total", value: $viewModel.total)
                        .onChange(of: viewModel.total) { newValue in
                            viewModel.updateTotal(newValue)
                        }
                    
                    AvailableBalanceView(balance: viewModel.availableBalance)
                    
                    TradeActionButton(tradeType: viewModel.selectedTradeType,
                                      action: viewModel.submitTrade)
                    .disabled(viewModel.amount <= 0 || viewModel.total <= 0 || viewModel.availableBalance <= 0)
                }
