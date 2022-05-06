// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ChainRep {
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
        uint256 reviewsReceivedCount;
        uint256 totalRating;
        uint256 rawRatingScore;
    }

    mapping(address => User) public userProfile;
    User[] public users;
    Review[] public reviews;
    event Reviewed(address reviewer, address indexed reviewed, Review review);

    function createReview(
        uint256 _rating,
        string memory _description,
        string memory _category,
        address _reviewer,
        address _reviewed
    ) public {
        reviewCount++;
        Review memory review = Review(
            reviewCount,
            _rating,
            _description,
            _category,
            _reviewer,
            _reviewed
        );
        reviews.push(review);
        User memory reviewed = userProfile[_reviewed];
        // Check if user profile has been initialized
        if (reviewed.reviewsReceivedCount > 0) {
            reviewed.reviewsReceivedCount++;
            reviewed.rawRatingScore += review.rating;
            reviewed.totalRating = (reviewed.rawRatingScore /
                reviewed.reviewsReceivedCount);
        } else {
            // initialize user profile if it doesn't exist
            reviewed.userAddress = _reviewed;
            reviewed.reviewsReceivedCount++;
            reviewed.totalRating = review.rating;
            reviewed.rawRatingScore = review.rating;
        }
        emit Reviewed(_reviewer, _reviewed, reviews[reviewCount]);
    }

    function userTotalRating(address _user) public view returns (uint256) {
        User memory user = userProfile[_user];
        return user.totalRating;
    }

    function getUserCategoryRating(address _user, string memory _category)
        public
        view
        returns (uint256)
    {
        uint256 categoryRating;
        uint256 categoryReviewCount;
        for (uint256 i = 0; i > reviewCount; i++) {
            Review memory review = reviews[i];
            if (
                review.reviewed == _user &&
                (keccak256(abi.encodePacked((review.category))) ==
                    keccak256(abi.encodePacked((_category))))
            ) {
                categoryReviewCount++;
                categoryRating += review.rating;
            }
        }
        return categoryRating / categoryReviewCount;
    }
}
