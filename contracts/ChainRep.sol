// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract ChainRep is Ownable {
    uint256 public reviewCount;

    struct Review {
        uint256 id;
        uint256 rating;
        string description;
        string category;
        address reviewer;
        address reviewed;
    }

    struct User {
        address userAddress;
        uint256[] givenReviewIds;
        uint256[] receivedReviewIds;
        uint256 reviewsReceivedCount;
        uint256 totalRating;
    }

    mapping(address => User) public userProfile;
    mapping(uint256 => Review) public singleReview;
    mapping(address => uint256) public userRating;
    event Reviewed(address reviewer, address indexed reviewed, Review review);

    function createReview(
        uint256 _rating,
        string memory _description,
        string memory _category,
        address _reviewer,
        address _reviewed
    ) public {
        reviewCount++;
        singleReview[reviewCount] = Review(
            reviewCount,
            _rating,
            _description,
            _category,
            _reviewer,
            _reviewed
        );
        Review memory review = singleReview[reviewCount];
        User storage reviewer = userProfile[_reviewer];
        User storage reviewed = userProfile[_reviewed];
        // Check if user profile has been initialized
        if (reviewed.userAddress == _reviewed) {
            reviewed.receivedReviewIds.push(reviewCount);
            reviewed.reviewsReceivedCount++;
            updateUserTotalRating(_reviewed);
        } else {
            // initialize user profile if it doesn't exist
            userProfile[_reviewed] = User(
                _reviewed,
                [0],
                [reviewCount],
                1,
                review.rating
            );
        }
        if (reviewer.userAddress == _reviewer) {
            reviewer.givenReviewIds.push(reviewCount);
        } else {
            userProfile[_reviewer] = User(_reviewer, [reviewCount], [0], 0, 0);
        }
        emit Reviewed(_reviewer, _reviewed, singleReview[reviewCount]);
    }

    function updateUserTotalRating(address _reviewed) internal {
        User memory reviewed = userProfile[_reviewed];
        uint256 userReviewCount = reviewed.reviewsReceivedCount;
        uint256 rating;
        for (uint256 i = 0; i < userReviewCount - 1; i++) {
            uint256 reviewIndex = reviewed.receivedReviewIds[i];
            Review memory review = singleReview[reviewIndex];
            rating = rating + review.rating;
        }
        reviewed.totalRating = rating / userReviewCount;
    }

    function getUserCategoryRating(address _reviewed, string memory _category)
        public
        view
        returns (uint256)
    {
        User memory reviewed = userProfile[_reviewed];
        uint256 userCategoryReviewCount;
        uint256 categoryRating;
        for (uint256 i = 0; i < reviewed.reviewsReceivedCount - 1; i++) {
            uint256 reviewIndex = reviewed.receivedReviewIds[i];
            Review memory review = singleReview[reviewIndex];
            if (
                (keccak256(abi.encodePacked((review.category))) ==
                    keccak256(abi.encodePacked((_category))))
            ) {
                userCategoryReviewCount++;
                categoryRating = categoryRating + review.rating;
            }
        }
        return categoryRating / userCategoryReviewCount;
    }
}
