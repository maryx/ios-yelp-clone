//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate {

    var businesses: [Business]!
    var searchTerm: String!
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120 // for scrollheight dimension
        
        searchBar = UISearchBar() // You have to put it here because it wont drag onto the nav part of the storyboard
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.delegate = self // otherwise those funcs wont work
        searchTerm = "cheese"
        getData(nil, categories: [], deals: false, distance: 0.25)
    }

    func getData(sort: Int?, categories: [String]?, deals: Bool?, distance: Double?) {
        var actualSort = YelpSortMode.init(rawValue: sort ?? 0)
        Business.searchWithTerm(searchTerm ?? "",
            sort: actualSort,
            categories: categories,
            deals: deals,
            completion: {
                (all: [Business]!, error: NSError!) -> Void in

                var distanceBusinesses = [Business]()
                // filter by distance if you want
                if (distance > 0) {
                    for business in all {
                        var stringDist = (business.distance! as NSString).substringToIndex(4)
                        var doubleDist = (stringDist as NSString).doubleValue
                        if (doubleDist < distance) {
                            distanceBusinesses.append(business)
                        }
                    }
                }
                self.businesses = distanceBusinesses
                self.tableView.reloadData()
                self.searchBar.text = self.searchTerm
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchTerm = searchText
        getData(nil, categories: [], deals: false, distance: 0.25)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (businesses != nil) {
            return businesses!.count
        } else {
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell // This returns back an AnyObject so we have to cast it
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    // You get this because you delegated it at the top
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        var deals = filters["deals"] as? Bool
        var sort = filters["sort"] as? Int
        var distance = filters["distance"] as? Double
        getData(sort, categories: categories, deals: deals, distance: distance)
    }
}
